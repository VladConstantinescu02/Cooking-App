namespace MsaCookingApp.Contracts.Features.Profile.DTOs;

public class SearchDietaryOptionsResultDto
{
    public string Message { get; set; }
    public IEnumerable<SearchDietaryOptionResult> Results { get; set; }

    public static SearchDietaryOptionsResultDto Create(string message, IEnumerable<SearchDietaryOptionResult> results)
    {
        return new SearchDietaryOptionsResultDto()
        {
            Message = message,
            Results = results
        };
    }
}