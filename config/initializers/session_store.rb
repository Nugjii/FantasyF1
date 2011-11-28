# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_fantasyf1_session',
  :secret      => 'bdefda69970528211c6232bf44a41e324c77c904b1f754a8e9d7f2fc431c6333cb9dcec5bedae99084fdd20d3e109bcf3a089d481953a2a292dd84f837c38cee'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
