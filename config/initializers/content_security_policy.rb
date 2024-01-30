# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# See the Securing Rails Applications Guide for more information:
# https://guides.rubyonrails.org/security.html#content-security-policy-header

# Rails.application.configure do
#   config.content_security_policy do |policy|
#     policy.default_src :self, :https
#     policy.font_src    :self, :https, :data
#     policy.script_src  :self, :https
#     policy.script_src_elem :self, :https, :unsafe_inline
#     policy.style_src   :self, :https, :unsafe_inline
#   #     # Specify URI for violation reports
#   #     # policy.report_uri "/csp-violation-report-endpoint"
#   #     policy.img_src     :self, :https, :data
#   #     policy.object_src  :none
#   end
# end
#   # Generate session nonces for permitted importmap, inline scripts, and inline styles.
#   config.content_security_policy_nonce_generator = ->(request) { request.session.id.to_s }
#   config.content_security_policy_nonce_directives = %w(script-src style-src)
#
#   # Report violations without enforcing the policy.
#   # config.content_security_policy_report_only = true
# end
