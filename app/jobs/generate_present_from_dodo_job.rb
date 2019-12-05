class GeneratePresentFromDodoJob < ActiveJob::Base

  def perform(letter)
    GeneratePresent.for letter, Vendors::Dodo
  end
end
