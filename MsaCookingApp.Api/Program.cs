using Microsoft.OpenApi.Models;
using MsaCookingApp.Business;
using MsaCookingApp.DataAccess;

var builder = WebApplication.CreateBuilder(args);
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

builder.Services.AddControllers();
builder.Services.AddBusinessLogic();
builder.Services.AddDataAccess(builder.Configuration);
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen((c) =>
{
    c.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "Msa Cooking Application API",
        Version = "v1"
    });
});

builder.Services.AddRouting(options => options.LowercaseUrls = true);

var app = builder.Build();
app.UseCors(allowedSpecificOrigin);
if (builder.Environment.IsDevelopment() || builder.Environment.IsProduction())
{
    app.UseDeveloperExceptionPage();
    app.UseSwagger();
    app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "Brackets.Play.API v1"));
}

app.MapControllers();
app.UseHttpsRedirection();

app.Run();