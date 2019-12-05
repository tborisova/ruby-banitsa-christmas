class GeneratePresentFromZaioBaioJob < ActiveJob::Base

  def perform(letter)
    GeneratePresentFromZaioBaio.execute letter
  end
end
