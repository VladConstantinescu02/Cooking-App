using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using MsaCookingApp.Api;
using MsaCookingApp.Api.Filters;
using MsaCookingApp.Business;
using MsaCookingApp.Business.Shared.Settings;
using MsaCookingApp.DataAccess;

var builder = WebApplication.CreateBuilder(args);

builder.WebHost.ConfigureKestrel((serverOptions) =>
{
    serverOptions.ListenAnyIP(5000);
    serverOptions.ListenAnyIP(5001, (options =>
    {
        options.UseHttps();
    }));
});

builder.Logging.ClearProviders();
builder.Logging.AddConsole();
builder.Logging.SetMinimumLevel(LogLevel.Information);

const string allowedSpecificOrigin = "AllowFlutterApp";
builder.Services.AddCors(options =>
{
    options.AddPolicy(name: allowedSpecificOrigin,
        policy =>
        {
            policy.AllowAnyOrigin()
                .AllowAnyMethod()
                .AllowAnyHeader();
        });
});
builder.Services.AddAuthentication(options =>
    {
        options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
        options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
    })
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = false,
            ValidateAudience = false,
            ValidateLifetime = true,
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration.GetValue<string>("Jwt:Secret") ?? ""))
        };
        
    });
builder.Services.AddControllers();
builder.Services.AddBusinessLogic();
builder.Services.AddDataAccess(builder.Configuration);
builder.Services.AddGlobalErrorHandling();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen((c) =>
{
    c.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "Msa Cooking Application API",
        Version = "v1"
    });
    c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme()
    {
        Name = "Authorization",
        Type = SecuritySchemeType.ApiKey,
        Scheme = "Bearer",
        BearerFormat = "JWT",
        In = ParameterLocation.Header,
        Description = "JWT Authorization header using the Bearer scheme. \r\n\r\n Enter 'Bearer' [space] and then your token in the text input below.\r\n\r\nExample: \"Bearer 1safsfsdfdfd\"",
    });
    c.AddSecurityRequirement(new OpenApiSecurityRequirement {
        {
            new OpenApiSecurityScheme {
                Reference = new OpenApiReference {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            new string[] {}
        }
    });
});

builder.Services.AddRouting(options => options.LowercaseUrls = true);
builder.Services.Configure<JwtOptions>(builder.Configuration.GetSection("Jwt"));
builder.Services.Configure<ApiClientsOptions>(builder.Configuration.GetSection("ApiClients"));
builder.Services.Configure<SpoonacularOptions>(builder.Configuration.GetSection("Spoonacular"));

builder.Services.AddHttpClient(builder.Configuration["ApiClients:Spoonacular:Name"] ?? "", client =>
{
    client.BaseAddress = new Uri(builder.Configuration["ApiClients:Spoonacular:BaseAddress"] ?? "");
});

var app = builder.Build();
app.UseCors(allowedSpecificOrigin);
if (builder.Environment.IsDevelopment() || builder.Environment.IsProduction())
{
    app.UseDeveloperExceptionPage();
    app.UseSwagger();
    app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "Brackets.Play.API v1"));
}

app.UseGlobalErrorHandling();
app.MapControllers();
app.UseHttpsRedirection();
app.UseAuthentication();
app.UseAuthorization();

app.Run();