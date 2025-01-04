using MsaCookingApp.Contracts.Shared.DTOs;
using MsaCookingApp.DataAccess.Entities;
using Profile = AutoMapper.Profile;

namespace MsaCookingApp.Business.Shared.MapperProfiles;

public class DietaryOptionMapperProfile : Profile
{
    public DietaryOptionMapperProfile()
    {
        CreateMap<DietaryOption, ProfileDietRestricionDto>();
    }
}