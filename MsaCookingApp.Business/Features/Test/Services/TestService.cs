﻿using AutoMapper;
using MsaCookingApp.Business.Shared.Exceptions;
using MsaCookingApp.Contracts.Features.Test.Abstractions.Services;
using MsaCookingApp.Contracts.Features.Test.DTOs;
using MsaCookingApp.Contracts.Shared.Abstractions.Repositories;
using MsaCookingApp.DataAccess.Entities;

namespace MsaCookingApp.Business.Features.Test.Services;

public class TestService : ITestService
{
    private readonly IMapper _mapper;
    private readonly IRepository<Ingredient> _ingredientRepository;

    public TestService(IRepository<Ingredient> ingredientRepository, IMapper mapper)
    {
        _ingredientRepository = ingredientRepository;
        _mapper = mapper;
    }

    public async Task<IEnumerable<IngredientDto>> GetAllIngredients()
    {
        var ingredients = (await _ingredientRepository.GetAllAsync())
            .Select((i) => _mapper.Map<IngredientDto>(i))
            .ToList();

        if (ingredients.Any())
        {
            throw new NotFoundException("Not found!");
        }
        return ingredients;
    }
}