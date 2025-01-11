using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Shared.DTOs;

public class UploadImageResultDto
{
    private string _message;
    private string _imageName;

    public required string Message
    {
        get => _message;
        [MemberNotNull(nameof(_message))] set => _message = value;
    }

    public required string ImageName
    {
        get => _imageName;
        [MemberNotNull(nameof(_imageName))] set => _imageName = value;
    }

    public static UploadImageResultDto Create(string message, string imageName)
    {
        return new UploadImageResultDto()
        {
            Message = message,
            ImageName = imageName
        };
    }
}