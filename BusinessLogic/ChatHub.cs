using System;
using System.Web;
using Microsoft.AspNet.SignalR;
using DataAccess.ChatTableAdapters;
using DataSets;
using System.Data;


namespace SignalRChat
{
    public class  ChatHub : Hub
    {
        public static DataSets.Chat.ChatDataTable getLastMessages(int gameID)
        {
            ChatTableAdapter chatTableAdapter = new ChatTableAdapter();
            Chat.ChatDataTable lastMessages = chatTableAdapter.getPreviousMessages(gameID);
            return lastMessages;
        }

        public static string getUsername(int userId)
        {
            ChatTableAdapter chatTableAdapter = new ChatTableAdapter();

            return chatTableAdapter.getUsername(userId).ToString();
        }

        public void storeMessage(int userId, int gameId, string message)
        {
            ChatTableAdapter chatTableAdapter = new ChatTableAdapter();
            chatTableAdapter.insertMessage(1, gameId, message, DateTime.Now);
        }

        public void sendLastMessages()
        {
            Chat.ChatDataTable lastMessages = getLastMessages(1);
            foreach (DataRow row in lastMessages.Rows)
            {
                
                Clients.All.broadcastMessage(row["userName"].ToString(), row["message"].ToString());
            }
        }

        public void Send(string userId, string message)
        {
            if (message == "newconnection")
            {
                sendLastMessages();
            }
            else
            {
                
                //recieve data
                //if new connection
                //retrieve last 20 messages
                //broadcast to individual
                //TODO// Clients.Client.
                //recieve message
                //send message to database

                //check game message is sent from
                //broadcast message to those members
                //System.Web.Security.Membership.getUser();
                // Call the broadcastMessage method to update clients.
                string userName = getUsername(Convert.ToInt16(userId));
                storeMessage(Convert.ToInt16(userId), 1, message);
                Clients.All.broadcastMessage(userName, message);
            }
        }
    }
}