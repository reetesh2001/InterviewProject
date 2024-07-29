require 'roo'

class CandidateImporter
  def initialize(file, user)
    @file = file
    @user = user
  end

  def import
    file_path = Rails.root.join('tmp', @file.filename.to_s).to_s

    File.open(file_path, 'wb') do |local_file|
     local_file.write(@file.download)
    end

    spreadsheet = Roo::Spreadsheet.open(file_path)
    header = spreadsheet.row(1).map(&:downcase) 
    header_mapping = {
      'name' => 'name',
      'email' => 'email',
      'phone' => 'phone',
      'role' => 'role',
      'qualification' => 'qualification',
      'college' => 'college',
      'experience' => 'experience',
      'company' => 'company'
    }

    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      mapped_row = row.transform_keys { |key| header_mapping[key] }
      candidate = @user.candidates.build(mapped_row)
      candidate.save!
    end

    File.delete(file_path) if File.exist?(file_path)
  end
end
