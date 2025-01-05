using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MsaCookingApp.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class AddedIngredientUnitEntity : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_FridgeIngredients_Ingredients_IngredientId",
                table: "FridgeIngredients");

            migrationBuilder.DropIndex(
                name: "IX_FridgeIngredients_IngredientId",
                table: "FridgeIngredients");

            migrationBuilder.AddColumn<string>(
                name: "IngredientId1",
                table: "FridgeIngredients",
                type: "TEXT",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "IngredientMeasuringUnitId",
                table: "FridgeIngredients",
                type: "INTEGER",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateTable(
                name: "IngredientMeasuringUnit",
                columns: table => new
                {
                    Id = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    UnitName = table.Column<string>(type: "TEXT", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_IngredientMeasuringUnit", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_FridgeIngredients_IngredientId1",
                table: "FridgeIngredients",
                column: "IngredientId1");

            migrationBuilder.CreateIndex(
                name: "IX_FridgeIngredients_IngredientMeasuringUnitId",
                table: "FridgeIngredients",
                column: "IngredientMeasuringUnitId");

            migrationBuilder.AddForeignKey(
                name: "FK_FridgeIngredients_IngredientMeasuringUnit_IngredientMeasuringUnitId",
                table: "FridgeIngredients",
                column: "IngredientMeasuringUnitId",
                principalTable: "IngredientMeasuringUnit",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_FridgeIngredients_Ingredients_IngredientId1",
                table: "FridgeIngredients",
                column: "IngredientId1",
                principalTable: "Ingredients",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_FridgeIngredients_IngredientMeasuringUnit_IngredientMeasuringUnitId",
                table: "FridgeIngredients");

            migrationBuilder.DropForeignKey(
                name: "FK_FridgeIngredients_Ingredients_IngredientId1",
                table: "FridgeIngredients");

            migrationBuilder.DropTable(
                name: "IngredientMeasuringUnit");

            migrationBuilder.DropIndex(
                name: "IX_FridgeIngredients_IngredientId1",
                table: "FridgeIngredients");

            migrationBuilder.DropIndex(
                name: "IX_FridgeIngredients_IngredientMeasuringUnitId",
                table: "FridgeIngredients");

            migrationBuilder.DropColumn(
                name: "IngredientId1",
                table: "FridgeIngredients");

            migrationBuilder.DropColumn(
                name: "IngredientMeasuringUnitId",
                table: "FridgeIngredients");

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
    }
}
