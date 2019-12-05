class GeneratePresentFromDodoJob < ActiveJob::Base

  def perform(letter)
    GeneratePresentFromDodo.execute letter
  end
end
