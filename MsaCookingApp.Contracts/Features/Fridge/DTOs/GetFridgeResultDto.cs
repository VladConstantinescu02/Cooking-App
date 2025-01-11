using System.Diagnostics.CodeAnalysis;
using MsaCookingApp.Contracts.Shared.DTOs;

namespace MsaCookingApp.Contracts.Features.Fridge.DTOs;

public class GetFridgeResultDto
{
    private string _message;
    private GetFridgeDto _fridge;
    private IEnumerable<WarningDto> _warnings = new List<WarningDto>();

    public required string Message
    {
        get => _message;
        [MemberNotNull(nameof(_message))] set => _message = value;
    }

    public required GetFridgeDto Fridge
    {
        get => _fridge;
        [MemberNotNull(nameof(_fridge))] set => _fridge = value;
    }

    public IEnumerable<WarningDto> Warnings
    {
        get => _warnings;
        set => _warnings = value;
    }

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