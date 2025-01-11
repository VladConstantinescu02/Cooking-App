using System.Diagnostics.CodeAnalysis;

namespace MsaCookingApp.Contracts.Features.Meals.DTOs;

public class GetAllDietaryOptionsResultDto
{
    private string _message;
    private IEnumerable<GetDietaryOptionDto> _dietaryOptions = new List<GetDietaryOptionDto>();

    public required string Message
    {
        get => _message;
        [MemberNotNull(nameof(_message))] set => _message = value;
    }

    public IEnumerable<GetDietaryOptionDto> DietaryOptions
    {
        get => _dietaryOptions;
        set => _dietaryOptions = value;
    }

    public static GetAllDietaryOptionsResultDto Create(string message, IEnumerable<GetDietaryOptionDto> dietaryOptions)
    {
        return new GetAllDietaryOptionsResultDto()
        {
            Message = message,
            DietaryOptions = dietaryOptions
        };
    }
}