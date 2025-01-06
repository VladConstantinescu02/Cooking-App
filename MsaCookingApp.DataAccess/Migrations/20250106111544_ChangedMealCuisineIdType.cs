using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MsaCookingApp.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class ChangedMealCuisineIdType : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_FridgeIngredients_Ingredients_IngredientId1",
                table: "FridgeIngredients");

            migrationBuilder.DropColumn(
                name: "IngredientId1",
                table: "FridgeIngredients");

            migrationBuilder.AlterColumn<int>(
                name: "MealCuisineId",
                table: "Meals",
                type: "INTEGER",
                nullable: false,
                oldClrType: typeof(Guid),
                oldType: "TEXT");

            migrationBuilder.AlterColumn<int>(
                name: "Id",
                table: "MealCuisines",
                type: "INTEGER",
                nullable: false,
                oldClrType: typeof(Guid),
                oldType: "TEXT")
                .Annotation("Sqlite:Autoincrement", true);

            migrationBuilder.CreateIndex(
                name: "IX_FridgeIngredients_IngredientId",
                table: "FridgeIngredients",
                column: "IngredientId");

            migrationBuilder.AddForeignKey(
                name: "FK_FridgeIngredients_Ingredients_IngredientId",
                table: "FridgeIngredients",
                column: "IngredientId",
                principalTable: "Ingredients",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_FridgeIngredients_Ingredients_IngredientId",
                table: "FridgeIngredients");

            migrationBuilder.DropIndex(
                name: "IX_FridgeIngredients_IngredientId",
                table: "FridgeIngredients");

            migrationBuilder.AlterColumn<Guid>(
                name: "MealCuisineId",
                table: "Meals",
                type: "TEXT",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "INTEGER");

            migrationBuilder.AlterColumn<Guid>(
                name: "Id",
                table: "MealCuisines",
                type: "TEXT",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "INTEGER")
                .OldAnnotation("Sqlite:Autoincrement", true);

            migrationBuilder.AddColumn<string>(
                name: "IngredientId1",
                table: "FridgeIngredients",
                type: "TEXT",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_FridgeIngredients_IngredientId1",
                table: "FridgeIngredients",
                column: "IngredientId1");

            migrationBuilder.AddForeignKey(
                name: "FK_FridgeIngredients_Ingredients_IngredientId1",
                table: "FridgeIngredients",
                column: "IngredientId1",
                principalTable: "Ingredients",
                principalColumn: "Id");
        }
    }
}
