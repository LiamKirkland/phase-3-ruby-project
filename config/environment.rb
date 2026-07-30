# frozen_string_literal: true

ENV["RACK_ENV"] ||= "development"

FAILURE_MESSAGE = "\e[3;31mInvalid input. Please try again.\e[0m"

# Require in Gems
require "bundler/setup"
Bundler.require(:default, ENV.fetch("RACK_ENV", nil))
require "active_record"

# Set up database connection directly via Active Record
require "yaml"
db_config = YAML.load_file(File.join(__dir__, "database.yml"))
ActiveRecord::Base.establish_connection(db_config[ENV.fetch("RACK_ENV", "development")])

# Require in all model files
require_all "app/models"

def display_banner
  clear_screen
  puts <<~BANNER
      .:::::::::::::::::::::BACKYARD:BASEBALL:::::::::::::::::::::.
    ..'                                      ....                  ..
    ..                            ......       ...                 ..
    EB                          .F.phillyS.     F.G                BK
    SA                         sS.F.Gi||BASE      BAL              AC
    AC                        EBALLBASEBA||S       .F.             SA
    BK                          tsS.F.philly         S.            EB
    LY                         ||BASEBALLBA           SE           BD
    LA                          BASEBA||S.F.phillyS.F .Gia         AR
    AR                          .F.Gi||BASEBALLBASEBALLBASEB       LA
    BD                        .F.phillyS.F.phillyS.F.Gi||BASE      LY
    EB      BA               SEBALLBASEBA||S.F.phillyS.F.philly    BK
    SA    SE|BA             ASEBALLBASEBALLBASEBA||S.F.phillyS.F   AC
    AC      LL              sS.F.Gi||BASEBALLBASEBALLBASEBA||S.F   SA
    BK                      ntsS.F.phillyS.F.Gi||BASEBALL          EB
      O                         EBALLBASEBA|'`'''''''''''           O
      '::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::'
  BANNER
end

def clear_screen
  system("clear") || system("cls")
end

def pause
  print "\nPress Enter to continue..."
  gets
end
