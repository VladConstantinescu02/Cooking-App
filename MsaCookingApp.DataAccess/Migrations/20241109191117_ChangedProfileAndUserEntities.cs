using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MsaCookingApp.DataAccess.Migrations
{
    /// <inheritdoc />
    public partial class ChangedProfileAndUserEntities : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Name",
                table: "Users",
                newName: "DisplayName");

            migrationBuilder.AddColumn<string>(
                name: "FullName",
                table: "Profiles",
                type: "TEXT",
                nullable: false,
                defaultValue: "");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "FullName",
                table: "Profiles");

            migrationBuilder.RenameColumn(
                name: "DisplayName",
                table: "Users",
                newName: "Name");
        }
    }
}
