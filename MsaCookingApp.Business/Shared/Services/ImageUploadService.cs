using System.Text;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Options;
using MsaCookingApp.Business.Shared.Exceptions;
using MsaCookingApp.Business.Shared.Settings;
using MsaCookingApp.Contracts.Shared.Abstractions.Services;
using MsaCookingApp.Contracts.Shared.DTOs;
using SixLabors.ImageSharp;
using SixLabors.ImageSharp.Formats.Jpeg;

namespace MsaCookingApp.Business.Shared.Services;

public class ImageUploadService : IImageUploadService
{
    private readonly IExceptionHandlingService _exceptionHandlingService;
    private readonly ImageUploadOptions _imageUploadOptions;

    public ImageUploadService(IExceptionHandlingService exceptionHandlingService, IOptions<ImageUploadOptions> imageUploadOptions)
    {
        _exceptionHandlingService = exceptionHandlingService;
        _imageUploadOptions = imageUploadOptions.Value;
    }

    public async Task<UploadImageResultDto> UploadImageAsync(IFormFile imageToUpload)
    {
        return await _exceptionHandlingService.ExecuteWithExceptionHandlingAsync(async () =>
        {
            var extension = Path.GetExtension(imageToUpload.FileName).ToLowerInvariant();
            if (_imageUploadOptions.SupportedExtensions != null && _imageUploadOptions.SupportedExtensions.Any())
            {
                if (!_imageUploadOptions.SupportedExtensions.Contains(extension))
                {
                    var imageExtensionsCsv = new StringBuilder();
                    foreach (var supportedExtension in _imageUploadOptions.SupportedExtensions)
                    {
                        if (supportedExtension == _imageUploadOptions.SupportedExtensions.Last())
                        {
                            imageExtensionsCsv.Append(supportedExtension);
                        }
                        else
                        {
                            imageExtensionsCsv.Append($"{supportedExtension}, ");
                        }
                    }

                    throw new ServiceException(StatusCodes.Status400BadRequest,
                        $"The file you provided doesn't have a supported extension. The supported extensions are {imageExtensionsCsv}");
                }
            }
            
            var directoryPath = _imageUploadOptions.DirectoryPath;
            if (!Directory.Exists(directoryPath))
            {
                throw new ServiceException(StatusCodes.Status500InternalServerError,
                    "Something went wrong with the image upload");
            }

            var newImageFileName = $"{imageToUpload.FileName}_{Guid.NewGuid()}.{Path.GetExtension(imageToUpload.FileName)}";
            var savePath = Path.Combine(directoryPath, newImageFileName);

            using (var stream = new FileStream(savePath, FileMode.Create))
            {
                await imageToUpload.CopyToAsync(stream);
            }

            using var image = Image.Load(savePath);
            var encoder = new JpegEncoder()
            {
                Quality = _imageUploadOptions.CompressQuality
            };
            image.Save(savePath, encoder);

            return UploadImageResultDto.Create("Successfully uploaded image", newImageFileName);
        }, "Error when uploading image");
    }

    public async Task<GetImageResultDto> GetImageAsync(string imageName)
    {
        return await _exceptionHandlingService.ExecuteWithExceptionHandlingAsync(() =>
        {
            var directoryPath = _imageUploadOptions.DirectoryPath;
            if (!Directory.Exists(directoryPath))
            {
                throw new ServiceException(StatusCodes.Status500InternalServerError,
                    "Something went wrong with the image upload");
            }

            var imagePath = Path.Combine(directoryPath, imageName);

            if (!File.Exists(imagePath))
            {
                throw new ServiceException(StatusCodes.Status500InternalServerError, "Cannot find file");
            }

            var contentType = GetContentType(imagePath);
            var fileStream = new FileStream(imagePath, FileMode.Open, FileAccess.Read);
            return Task.FromResult(GetImageResultDto.Create(contentType, fileStream));
        }, "Error when retrieving image");

    }
    
    private string GetContentType(string filePath)
    { 
        var extension = Path.GetExtension(filePath).ToLowerInvariant();
        if (_imageUploadOptions.SupportedExtensionsContentType != null)
        {
            return _imageUploadOptions.SupportedExtensionsContentType[extension];
        }

        return "";
    }
}