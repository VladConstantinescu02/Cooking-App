using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MsaCookingApp.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class ChangedProfileEntity : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Profiles_DietaryOptions_DietaryOptionId",
                table: "Profiles");

            migrationBuilder.AlterColumn<int>(
                name: "DietaryOptionId",
                table: "Profiles",
                type: "INTEGER",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "INTEGER");

            migrationBuilder.AddForeignKey(
                name: "FK_Profiles_DietaryOptions_DietaryOptionId",
                table: "Profiles",
                column: "DietaryOptionId",
                principalTable: "DietaryOptions",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Profiles_DietaryOptions_DietaryOptionId",
                table: "Profiles");

            migrationBuilder.AlterColumn<int>(
                name: "DietaryOptionId",
                table: "Profiles",
                type: "INTEGER",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "INTEGER",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Profiles_DietaryOptions_DietaryOptionId",
                table: "Profiles",
                column: "DietaryOptionId",
                principalTable: "DietaryOptions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
