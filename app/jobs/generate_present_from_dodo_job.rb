class GeneratePresentFromDodoJob < ActiveJob::Base

  def perform(letter)
    GeneratePresent.execute letter
  end
end
