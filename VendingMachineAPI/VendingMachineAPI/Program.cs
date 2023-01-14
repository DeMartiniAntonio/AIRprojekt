using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using VendingMachineAPI.Data;
using Pomelo.EntityFrameworkCore.MySql;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

//builder.Services.AddDbContext<VendingMachineAPIDbContext>(options => options.UseInMemoryDatabase("VendingMachineDb"));
builder.Services.AddDbContext<VendingMachineAPIDbContext>(options => options.UseMySql(builder.Configuration.GetConnectionString("VendingMachineApp"), ServerVersion.AutoDetect("8.0.22")));


var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
