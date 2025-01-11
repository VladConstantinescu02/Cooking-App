namespace MsaCookingApp.Contracts.Features.Profile.DTOs;

public class SearchDietaryOptionsResultDto
{
    private string _message = "";
    private IEnumerable<SearchDietaryOptionResult> _results = new List<SearchDietaryOptionResult>();

    public string Message
    {
        get => _message;
        set => _message = value;
    }

    public IEnumerable<SearchDietaryOptionResult> Results
    {
        get => _results;
        set => _results = value;
    }

    public static SearchDietaryOptionsResultDto Create(string message, IEnumerable<SearchDietaryOptionResult> results)
    {
        return new SearchDietaryOptionsResultDto()
        {
            Message = message,
            Results = results
        };
    }
}