# Backyard Baseball - Stat Management
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

### Project Setup
- Pull the app down from GitHub
  - `git clone git@github.com:LiamKirkland/phase-3-ruby-project.git`
- Navigate to the project directory and install the dependencies
  - This can be done by running `cd phase-3-ruby-project` and then `bundle install`
- Once the gems are done installing, run the following commands:
  - `bundle exec rake db:migrate`
  - `bundle exec rake db:seed`
  - `bundle exec cli/main.rb`
- You should now see the landing menu! Follow the menu prompts and explore :)

### Core Features
- ***Team Management***
  - View a list of all teams
  - View the details of a specific team
  - Add a new team
  - Update an existing team
  - Delete a team
- ***Game Management***
  - View a list of all games
  - View the details of a specific game
  - Add a new game
  - Update an existing game
  - Delete a game
- ***Player Management***
  - View a list of all players
  - View the details of a specific player
  - Add a new player
  - Update an existing player
  - Delete a player
- ***Game Simulation***
  - Select two teams to face-off
  - Game events are displayed based on players from those teams
  - Outcome has its results weighted based on the teams' ratings
  - Game is saved to the database
 
