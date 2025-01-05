using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace MsaCookingApp.Api.Controllers;

[Authorize]
[Route("/api/fridge")]
public class FridgesController : Controller
{
    
}