class GeneratePresent

  def for(letter, vendor)
    parsed_letter = vendor.parse

    child = Child.find_by child_id: parsed_letter[:child_id]

    if child.blank?
      SendNotificationToElvesJob.perform_later child_id
      return
    end

    if Coal.exists?('created_at::date >= :beginning_of_the_year AND child_id = :child_id', Time.beginning_of_the_year, child_id)
      SendNotificationToMrsKringleJob.perform_later child.id
      return
    end

    present = PresentWishes.create! parsed_letter

    if child.age > 18 && child.has_emotional_problems?
      SendNotificationToDestinyJob.perform_later present.id
    end

    SendPresentToSantaJob.perform_later present.id
  end
end
