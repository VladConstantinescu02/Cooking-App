using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MsaCookingApp.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class AddedNewFieldInIngredientMeasuringUnitEntity : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "UnitSuffix",
                table: "IngredientMeasuringUnits",
                type: "TEXT",
                maxLength: 5,
                nullable: false,
                defaultValue: "");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "UnitSuffix",
                table: "IngredientMeasuringUnits");
        }
    }
}
