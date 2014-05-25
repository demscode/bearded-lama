using System;
using System.Web;
using System.Web.UI;
using System.Web.Routing;
using Microsoft.AspNet.SignalR;
using DataAccess.ChatTableAdapters;
using DataAccess.UsersTableAdapters;
using DataSets;
using System.Data;
using System.Web.Security;



namespace BusinessLogic.Chat
{

    public class Room : Hub
    {
        public static int getUserId(string userName)
        {
            UsersTableAdapter userTableAdapter = new UsersTableAdapter();
            object id = userTableAdapter.GetUserIdFromUserName(userName);
            return Convert.ToInt16(id.ToString());
        }

        public void storeMessage(int gameId, string message)
        {
            ChatTableAdapter chatTableAdapter = new ChatTableAdapter();
            int userId = getUserId(Membership.GetUser().ToString());
            chatTableAdapter.insertMessage(getUserId(Membership.GetUser().ToString()), gameId, message, DateTime.Now);
        }

        public void sendLastMessages()
        {
            ChatTableAdapter chatTableAdapter = new ChatTableAdapter();
            DataSets.Chat.ChatDataTable lastMessages = getLastMessages(1);

            foreach (DataSets.Chat.ChatRow row in lastMessages.Rows)
            {
                int userid = Convert.ToInt32(row.userId);
                object name = chatTableAdapter.GetUserNameChat(userid);
                Clients.Caller.broadcastMessage(name, row.message.ToString(), 1);
            }
        }
        public static DataSets.Chat.ChatDataTable getLastMessages(int gameId)
        {

            ChatTableAdapter chatTableAdapter = new ChatTableAdapter();
            DataSets.Chat.ChatDataTable lastMessages = chatTableAdapter.GetTwentyMessages(gameId);
            return lastMessages; 
        }

        public void Send(string modifier, string message, int gameId)
        {
            if (modifier == "newconnection")
            {
                Groups.Add(Context.ConnectionId, Convert.ToString(gameId));
                sendLastMessages();
            }
            else if (modifier == "")
            {
                
                storeMessage(gameId, message);

                Clients.Group(Convert.ToString(gameId)).broadcastMessage(Membership.GetUser().UserName, message);
                
            }
        }
    }
}