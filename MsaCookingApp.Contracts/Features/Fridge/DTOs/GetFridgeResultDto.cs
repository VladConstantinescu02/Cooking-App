using MsaCookingApp.Contracts.Shared.DTOs;

namespace MsaCookingApp.Contracts.Features.Fridge.DTOs;

public class GetFridgeResultDto
{
    public required string Message { get; set; }
    public required GetFridgeDto Fridge { get; set; }
    public IEnumerable<WarningDto> Warnings { get; set; } = new List<WarningDto>();

    public static GetFridgeResultDto Create(string message, GetFridgeDto fridge, IEnumerable<WarningDto> warnings)
    {
        return new GetFridgeResultDto()
        {
            Message = message,
            Fridge = fridge,
            Warnings = warnings
        };
    }
}