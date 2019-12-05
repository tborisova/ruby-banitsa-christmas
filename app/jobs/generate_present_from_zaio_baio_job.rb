class GeneratePresentFromZaioBaioJob < ActiveJob::Base

  def perform(letter)
    GeneratePresent.execute letter
  end
end
