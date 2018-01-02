desc 'Rename this application'
task :rename, [:name] => :environment do |_t, args|
  files = Dir.glob(%w[rb yml].map { |ext| Rails.root.join("**/*.#{ext}") } + %w[Rakefile])
  before_name = Rails.application.class.name.split('::').first
  before_name_dashes = split_with_dashes(before_name)

  (after_name = args.name) || raise('Pass a new name as an argument: $ rake rename[MyApp]')
  after_name_dashes = split_with_dashes(after_name)

  files.each do |file|
    # Swap in the new name
    renamed = File.read(file)
                  .gsub(/#{before_name}/, after_name)
                  .gsub(/#{before_name_dashes}/, after_name_dashes)
    # Write the updated contents
    File.write(file, renamed)
  end

  # rename root directory
  new_path = Rails.root.to_s.split('/')[0...-1].push(after_name_dashes).join('/')
  FileUtils.mv(Rails.root.to_s, new_path)
end

def split_with_dashes(string)
  string.gsub(/::/, '/')
        .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
        .gsub(/([a-z\d])([A-Z])/, '\1_\2')
        .gsub(/([1-9])/, '_\1\2')
        .tr('_', '-')
        .downcase
end
