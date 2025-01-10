using System.Globalization;
using MsaCookingApp.Contracts.Features.Meals.DTOs;
using MsaCookingApp.DataAccess.Entities;
using Profile = AutoMapper.Profile;

namespace MsaCookingApp.Business.Shared.MapperProfiles;

public class MealsMapperProfile : Profile
{
    public MealsMapperProfile()
    {
        CreateMap<SpoonacularGetMealDto, Meal>()
            .ForMember(dest => dest.Id, opt => opt.MapFrom(src => Guid.NewGuid()))
            .ForMember(dest => dest.SpoonacularId, opt => opt.MapFrom(src => src.Id))
            .ForMember(dest => dest.Name, opt => opt.MapFrom(src => src.Title))
            .ForMember(dest => dest.Summary, opt => opt.MapFrom(src => src.Summary))
            .ForMember(dest => dest.ReadyInMinutes, opt => opt.MapFrom(src => src.ReadyInMinutes))
            .ForMember(dest => dest.Image, opt => opt.MapFrom(src => src.Image))
            .ForMember(dest => dest.LastPreparedAt,
                opt => opt.Ignore())
            .ForMember(dest => dest.WasPrepared, opt => opt.Ignore())
            .ForMember(dest => dest.ProfileId,
                opt => opt.MapFrom((src, dest, destMember, context) => context.Items["ProfileId"]))
            .ForMember(opt => opt.IngredientsJson,
                opt => opt.MapFrom((src, dest, destMember, context) => context.Items["IngredientsJson"]));

        CreateMap<Meal, GetAllMealsMealDto>();
        CreateMap<DietaryOption, GetDietaryOptionDto>();
        CreateMap<MealCuisine, GetMealCuisineDto>();
        CreateMap<MealType, GetMealTypeDto>();
    }
}