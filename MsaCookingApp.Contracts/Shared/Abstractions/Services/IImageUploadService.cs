using Microsoft.AspNetCore.Http;
using MsaCookingApp.Contracts.Shared.DTOs;

namespace MsaCookingApp.Contracts.Shared.Abstractions.Services;

public interface IImageUploadService
{
    Task<UploadImageResultDto> UploadImageAsync(IFormFile imageToUpload);
    Task<GetImageResultDto> GetImageAsync(string imageName);
}