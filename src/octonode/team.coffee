#
# team.coffee: Github organization team class
#
# Copyright © 2011 Pavan Kumar Sunkara. All rights reserved
#

# Requiring modules

# Initiate class
class Team

  constructor: (@id, @client) ->

  # Get a team
  # '/teams/37' GET
  info: (cb) ->
    @client.get "/teams/#{@id}", (err, s, b, h)  ->
      return cb(err) if err
      if s isnt 200 then cb(new Error('Team info error')) else cb null, b, h

  # Edit a team
  # '/teams/37' PATCH
  update: (info, cb) ->
    @client.patch "/teams/#{@id}", info, (err, s, b, h) ->
      return cb(err) if err
      if s isnt 200 then cb(new Error('Team update error')) else cb null, b, h

  # Get a teams's members
  # '/teams/37/members' GET
  # - page or query object, optional - params[0]
  # - per_page, optional             - params[1]
  members: (params..., cb) ->
    @client.get "/teams/#{@id}/members", params..., (err, s, b, h)  ->
      return cb(err) if err
      if s isnt 200 then cb(new Error('Team members error')) else cb null, b, h

  # Check a team's member
  # '/teams/37/members/pksunkara' GET
  member: (user, cb) ->
    @client.get "/teams/#{@id}/members/#{user}", (err, s, b, h)  ->
      return cb(err) if err
      cb null, s is 204, h

  # Add a user to a team (must have admin permissions to do so)
  # '/teams/37/members/pksunkara' PUT
  addUser: (user, cb) ->
    @client.put "/teams/#{@id}/members/#{user}", null,  (err, s, b, h) ->
      return cb(err) if err
      if s isnt 204 then cb(new Error("Team addUser error")) else cb null, b, h

  # Remove a user from a team (must have admin permissions to do so)
  # '/teams/37/members/pksunkara' DELETE
  removeUser: (user, cb) ->
    @client.del "/teams/#{@id}/members/#{user}", null, (err, s, b, h) ->
      return cb(err) if err
      if s isnt 204 then cb(new Error("Team removeUser error")) else cb null, b, h

  # Check a team's membership
  # '/teams/37/memberships/pksunkara' GET
  membership: (user, cb) ->
    @client.get "/teams/#{@id}/memberships/#{user}", (err, s, b, h)  ->
      return cb(err) if err
      cb null, s is 204, h

  # Add a user to a team's membership
  # '/teams/37/memberships/pksunkara' PUT
  addMembership: (user, cb) ->
    @client.put "/teams/#{@id}/memberships/#{user}", null,  (err, s, b, h) ->
      return cb(err) if err
      if s isnt 200 then cb(new Error("Team membership error")) else cb null, b, h

  # Remove a user from a team's membership
  # '/teams/37/memberships/pksunkara' DELETE
  removeMembership: (user, cb) ->
    @client.del "/teams/#{@id}/memberships/#{user}", null, (err, s, b, h) ->
      return cb(err) if err
      if s isnt 204 then cb(new Error("Team removeMembership error")) else cb null, b, h

  # List repos of a team
  # '/teams/37/repos/' GET
  # - page or query object, optional - params[0]
  # - per_page, optional             - params[1]
  repos: (params..., cb) ->
    @client.get "/teams/#{@id}/repos", params..., (err, s, b, h) ->
      return cb(err) if err
      if s isnt 200 then cb(new Error("Team repos error")) else cb null, b, h

# Export module
module.exports = Team
