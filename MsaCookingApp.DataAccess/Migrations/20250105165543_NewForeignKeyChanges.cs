using System;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MsaCookingApp.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class NewForeignKeyChanges : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "MealTypeId1",
                table: "Meals");
            
            migrationBuilder.DropColumn(
                name: "IngredientId1",
                table: "FridgeIngredients");

            migrationBuilder.AlterColumn<int>(
                name: "MealTypeId",
                table: "Meals",
                type: "INTEGER",
                nullable: false,
                oldClrType: typeof(Guid),
                oldType: "TEXT");
            
            migrationBuilder.AddForeignKey(
                name: "FK_ChallengeSubmissions_Profiles_ParticipantProfileId",
                table: "ChallengeSubmissions",
                column: "ParticipantProfileId",
                principalTable: "Profiles",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_FridgeIngredients_IngredientMeasuringUnits_IngredientMeasuringUnitId",
                table: "FridgeIngredients",
                column: "IngredientMeasuringUnitId",
                principalTable: "IngredientMeasuringUnits",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Meals_MealTypes_MealTypeId",
                table: "Meals",
                column: "MealTypeId",
                principalTable: "MealTypes",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.DropForeignKey(
                name: "FK_Meals_MealTypes_MealTypeId1",
                table: "Meals");
            
            migrationBuilder.DropForeignKey(
                name: "FK_FridgeIngredients_Ingredients_IngredientId1",
                table: "FridgeIngredients");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ChallengeSubmissions_Profiles_ParticipantProfileId",
                table: "ChallengeSubmissions");

            migrationBuilder.DropForeignKey(
                name: "FK_FridgeIngredients_IngredientMeasuringUnits_IngredientMeasuringUnitId",
                table: "FridgeIngredients");

            migrationBuilder.DropForeignKey(
                name: "FK_FridgeIngredients_Ingredients_IngredientId1",
                table: "FridgeIngredients");

            migrationBuilder.DropForeignKey(
                name: "FK_Meals_MealTypes_MealTypeId",
                table: "Meals");

            migrationBuilder.DropTable(
                name: "IngredientMeasuringUnits");

            migrationBuilder.DropIndex(
                name: "IX_Meals_MealTypeId",
                table: "Meals");

            migrationBuilder.DropIndex(
                name: "IX_FridgeIngredients_IngredientId1",
                table: "FridgeIngredients");

            migrationBuilder.DropIndex(
                name: "IX_FridgeIngredients_IngredientMeasuringUnitId",
                table: "FridgeIngredients");

            migrationBuilder.DropIndex(
                name: "IX_ChallengeSubmissions_ParticipantProfileId",
                table: "ChallengeSubmissions");

            migrationBuilder.DropColumn(
                name: "IngredientId1",
                table: "FridgeIngredients");

            migrationBuilder.DropColumn(
                name: "IngredientMeasuringUnitId",
                table: "FridgeIngredients");

            migrationBuilder.AlterColumn<Guid>(
                name: "MealTypeId",
                table: "Meals",
                type: "TEXT",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "INTEGER");

            migrationBuilder.AddColumn<Guid>(
                name: "ProfileId",
                table: "ChallengeSubmissions",
                type: "TEXT",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.CreateIndex(
                name: "IX_FridgeIngredients_IngredientId",
                table: "FridgeIngredients",
                column: "IngredientId");

            migrationBuilder.CreateIndex(
                name: "IX_ChallengeSubmissions_ProfileId",
                table: "ChallengeSubmissions",
                column: "ProfileId");

            migrationBuilder.AddForeignKey(
                name: "FK_ChallengeSubmissions_Profiles_ProfileId",
                table: "ChallengeSubmissions",
                column: "ProfileId",
                principalTable: "Profiles",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_FridgeIngredients_Ingredients_IngredientId",
                table: "FridgeIngredients",
                column: "IngredientId",
                principalTable: "Ingredients",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
