# frozen_string_literal: true
module Hyrax
  module Actors
    class LeaseActor
      attr_reader :work

      # @param [Hydra::Works::Work] work
      def initialize(work)
        @work = work
      end

      # Update the visibility of the work to match the correct state of the lease, then clear the lease date, etc.
      # Saves the lease and the work
      def destroy
        case work
        when Valkyrie::Resource
          lease_manager = Hyrax::LeaseManager.new(resource: work)
          return if lease_manager.lease.lease_expiration_date.blank?

          lease_manager.deactivate!
          work.lease = Hyrax.persister.save(resource: lease_manager.lease)
          Hyrax::AccessControlList(work).save
        else
          work.lease_visibility! # If the lease has lapsed, update the current visibility.
          work.deactivate_lease!
          work.lease.save!
          work.save!
        end
      end
    end
  end
end
