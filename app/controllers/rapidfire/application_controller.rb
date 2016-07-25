module Rapidfire
  class ApplicationController < ::ApplicationController
    helper_method :can_administer?

    def authenticate_administrator!
      unless can_administer?
        raise Rapidfire::AccessDenied.new("cannot administer questions")
      end
    end

    # Override prefixes to consider the scoped.
    # for method current_user
    def scoped
      :user
    end

    def current_user
      send 'current_'+scoped.to_s
    end
  end
end
