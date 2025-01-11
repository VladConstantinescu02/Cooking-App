using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Shared.DTOs;

public class UploadMealImageSubmissionResultDto
{
    private string _message;

    public required string Message
    {
        get => _message;
        [MemberNotNull(nameof(_message))] set => _message = value;
    }

    public static UploadMealImageSubmissionResultDto Create(string message)
    {
        return new UploadMealImageSubmissionResultDto()
        {
            Message = message
        };
    }
}