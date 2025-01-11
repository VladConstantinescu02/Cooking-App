namespace MsaCookingApp.Business.Shared.Settings;

public class ImageUploadOptions
{
    public string? DirectoryPath { get; set; }
    public int? CompressQuality { get; set; }
    public IEnumerable<string>? SupportedExtensions { get; set; }
    public IDictionary<string, string>? SupportedExtensionsContentType { get; set; }
}