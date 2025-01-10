using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MsaCookingApp.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class ChangedMealEntity : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Meals_MealCuisines_MealCuisineId",
                table: "Meals");

            migrationBuilder.DropForeignKey(
                name: "FK_Meals_MealTypes_MealTypeId",
                table: "Meals");

            migrationBuilder.DropForeignKey(
                name: "FK_Meals_MealTypes_MealTypeId1",
                table: "Meals");

            migrationBuilder.DropIndex(
                name: "IX_Meals_MealCuisineId",
                table: "Meals");

            migrationBuilder.DropIndex(
                name: "IX_Meals_MealTypeId",
                table: "Meals");

            migrationBuilder.DropIndex(
                name: "IX_Meals_MealTypeId1",
                table: "Meals");

            migrationBuilder.DropColumn(
                name: "MealCuisineId",
                table: "Meals");

            migrationBuilder.DropColumn(
                name: "MealTypeId",
                table: "Meals");

            migrationBuilder.DropColumn(
                name: "TotalCalories",
                table: "Meals");

            migrationBuilder.RenameColumn(
                name: "TotalGrams",
                table: "Meals",
                newName: "ReadyInMinutes");

            migrationBuilder.RenameColumn(
                name: "RecipeDescription",
                table: "Meals",
                newName: "Summary");

            migrationBuilder.RenameColumn(
                name: "MealTypeId1",
                table: "Meals",
                newName: "WasPrepared");

            migrationBuilder.AddColumn<string>(
                name: "Image",
                table: "Meals",
                type: "TEXT",
                maxLength: 250,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "LastPreparedAt",
                table: "Meals",
                type: "TEXT",
                maxLength: 250,
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Image",
                table: "Meals");

            migrationBuilder.DropColumn(
                name: "LastPreparedAt",
                table: "Meals");

            migrationBuilder.RenameColumn(
                name: "WasPrepared",
                table: "Meals",
                newName: "MealTypeId1");

            migrationBuilder.RenameColumn(
                name: "Summary",
                table: "Meals",
                newName: "RecipeDescription");

            migrationBuilder.RenameColumn(
                name: "ReadyInMinutes",
                table: "Meals",
                newName: "TotalGrams");

            migrationBuilder.AddColumn<int>(
                name: "MealCuisineId",
                table: "Meals",
                type: "INTEGER",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "MealTypeId",
                table: "Meals",
                type: "INTEGER",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<double>(
                name: "TotalCalories",
                table: "Meals",
                type: "REAL",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.CreateIndex(
                name: "IX_Meals_MealCuisineId",
                table: "Meals",
                column: "MealCuisineId");

            migrationBuilder.CreateIndex(
                name: "IX_Meals_MealTypeId",
                table: "Meals",
                column: "MealTypeId");

            migrationBuilder.CreateIndex(
                name: "IX_Meals_MealTypeId1",
                table: "Meals",
                column: "MealTypeId1");

            migrationBuilder.AddForeignKey(
                name: "FK_Meals_MealCuisines_MealCuisineId",
                table: "Meals",
                column: "MealCuisineId",
                principalTable: "MealCuisines",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Meals_MealTypes_MealTypeId",
                table: "Meals",
                column: "MealTypeId",
                principalTable: "MealTypes",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Meals_MealTypes_MealTypeId1",
                table: "Meals",
                column: "MealTypeId1",
                principalTable: "MealTypes",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
