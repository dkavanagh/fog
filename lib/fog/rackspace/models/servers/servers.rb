module Fog
  module Rackspace
    class Servers

      def servers
        Fog::Rackspace::Servers::Servers.new(:connection => self)
      end

      class Servers < Fog::Collection

        def all
          data = connection.list_servers_details.body
          servers = Fog::Rackspace::Servers::Servers.new({
            :connection => connection
          })
          for server in data['servers']
            servers << Fog::Rackspace::Servers::Server.new({
              :collection => servers,
              :connection => connection
            }.merge!(server))
          end
          servers
        end

        def create(attributes = {})
          server = new(attributes)
          server.save
          server
        end

        def get(id)
          connection.get_server_details(id)
        rescue Fog::Errors::NotFound
          nil
        end

        def new(attributes = {})
          Fog::Rackspace::Servers::Server.new({
            :collection => self,
            :connection => connection
          }.merge!(attributes))
        end

        def reload
          all
        end

      end

    end
  end
end