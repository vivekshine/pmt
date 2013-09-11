# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_pmt_session',
  :secret      => '524844c4e3af4237cf1e3c8de22ca432f922d8eac1107b6fb1ac6a52d49e779ac7dfa2234eea676e9bc768d977d3ac370f2a98942d63644b545aff5ebb2052f8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
# ActionController::Base.session_store = :p_store
