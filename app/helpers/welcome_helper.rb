module WelcomeHelper
    def downgrade
        current_user.update_attribute(:role, "standard")
    end
end
