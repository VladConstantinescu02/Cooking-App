using MsaCookingApp.Contracts.Features.Profile.DTOs;

namespace MsaCookingApp.Contracts.Features.Profile.Abstractions.Services;

public interface IProfilesService
{
    Task<GetProfileResponseDto> GetProfileAsync(string? userEmail);
    Task<CreateProfileResponseDto> CreateProfileAsync(CreateProfileDto createProfileDto, string? userEmail);
    Task<UpdateProfileResponseDto> UpdateProfileAsync(UpdateProfileDto updateProfileDto, string? userEmail);
    Task<DeleteProfileResponseDto> DeleteProfileAsync(string? userEmail);
    Task<SearchDietaryOptionsResultDto> SearchDietaryOptionAsync(string query);
}