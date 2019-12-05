class GeneratePresentFromZaioBaioJob < ActiveJob::Base

  def perform(letter)
    GeneratePresent.for letter, Vendors::ZaioBaio
  end
end
