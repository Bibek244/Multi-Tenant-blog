class HardJob
  include Sidekiq::Job

  def perform
    service = ::OrganizationAdder::CsvImportService.new
    if service.execute.success?
      redirect_to organizations_path, notice: 'Organizations imported successfully'
    else
      redirect_to new_user_registration_path, notice: service.errors
    end
  end
end
