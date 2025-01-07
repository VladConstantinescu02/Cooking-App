using MsaCookingApp.Contracts.Features.Fridge.DTOs;
using MsaCookingApp.Contracts.Features.Test.DTOs;
using MsaCookingApp.Contracts.Shared.DTOs;
using MsaCookingApp.DataAccess.Entities;
using Profile = AutoMapper.Profile;

namespace MsaCookingApp.Business.Shared.MapperProfiles;

public class IngredientMapperProfile : Profile
{
    public IngredientMapperProfile()
    {
        CreateMap<Ingredient, IngredientDto>();
        CreateMap<Ingredient, ProfileAlergenDto>();
        CreateMap<IngredientMeasuringUnit, GetIngredientMeasuringUnitDto>();
        CreateMap<FridgeIngredient, GetFridgeIngredientDto>()
            .ForMember(dest => dest.IngredientId, opt => opt.MapFrom(src => src.IngredientId))
            .ForMember(dest => dest.Name, opt => opt.MapFrom(src => src.Ingredient.Name))
            .ForMember(dest => dest.CaloriesPer100Grams, opt => opt.MapFrom(src => src.Ingredient.CaloriesPer100Grams))
            .ForMember(dest => dest.Quantity, opt => opt.MapFrom(src => src.Quantity))
            .ForMember(dest => dest.IngredientMeasuringUnitSuffix, opt => opt.MapFrom(src => src.IngredientMeasuringUnit.UnitSuffix));
    }
}