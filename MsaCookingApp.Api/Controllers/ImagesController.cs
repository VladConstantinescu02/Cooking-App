using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MsaCookingApp.Contracts.Shared.Abstractions.Services;

namespace MsaCookingApp.Api.Controllers;

[Authorize]
[Route("/api/images")]
public class ImagesController : Controller
{
    private readonly IImageUploadService _imageUploadService;

    public ImagesController(IImageUploadService imageUploadService)
    {
        _imageUploadService = imageUploadService;
    }

    [HttpGet]
    public async Task<IActionResult> GetImageAsync(string imageName)
    {
        var getImageResult = await _imageUploadService.GetImageAsync(imageName);
        return new FileStreamResult(getImageResult.FileStream, getImageResult.ContentType)
        {
            FileDownloadName = imageName
        };
    }
}