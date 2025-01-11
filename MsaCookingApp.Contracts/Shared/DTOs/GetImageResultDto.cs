using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Shared.DTOs;

public class GetImageResultDto
{
    private string _contentType;
    private FileStream _fileStream;

    public required string ContentType
    {
        get => _contentType;
        [MemberNotNull(nameof(_contentType))] set => _contentType = value;
    }

    public required FileStream FileStream
    {
        get => _fileStream;
        [MemberNotNull(nameof(_fileStream))] set => _fileStream = value;
    }

    public static GetImageResultDto Create(string contentType, FileStream fileStream)
    {
        return new GetImageResultDto()
        {
            ContentType = contentType,
            FileStream = fileStream
        };
    }
}