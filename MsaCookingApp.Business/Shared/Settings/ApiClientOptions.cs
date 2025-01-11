namespace MsaCookingApp.Business.Shared.Settings;

public class ApiClientOptions
{
    private string? _name;
    private string? _baseAddress;

    public ApiClientOptions(string? baseAddress, string? name)
    {
        BaseAddress = baseAddress;
        Name = name;
    }

    public string? Name
    {
        get => _name;
        set => _name = value;
    }

    public string? BaseAddress
    {
        get => _baseAddress;
        set => _baseAddress = value;
    }
}