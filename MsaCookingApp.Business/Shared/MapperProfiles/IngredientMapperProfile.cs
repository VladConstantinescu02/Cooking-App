using MsaCookingApp.Contracts.Features.Test.DTOs;
using MsaCookingApp.DataAccess.Entities;
using Profile = AutoMapper.Profile;

namespace MsaCookingApp.Business.Shared.MapperProfiles;

public class IngredientMapperProfile : Profile
{
    public IngredientMapperProfile()
    {
        CreateMap<Ingredient, IngredientDto>();
    }
}