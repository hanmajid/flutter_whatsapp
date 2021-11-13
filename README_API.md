<!-- omit in toc -->
# flutter_whatsapp API

`flutter_whatsapp` uses dummy API server. This page contains the documentation of the API server.

<!-- omit in toc -->
## Endpoint List

- [1. Chat Endpoints](#1-chat-endpoints)
  - [1.1. `GET` all chats](#11-get-all-chats)
  - [1.2. `GET` chat detail](#12-get-chat-detail)
  - [1.3. `POST` new chat message](#13-post-new-chat-message)
- [2. Call Endpoints](#2-call-endpoints)
  - [2.1. `GET` all calls](#21-get-all-calls)
- [3. Status Endpoints](#3-status-endpoints)
  - [3.1. `GET` all statuses](#31-get-all-statuses)
  - [3.2. `GET` status detail](#32-get-status-detail)

### 1. Chat Endpoints

#### 1.1. `GET` all chats

|             |                                  |
| ----------- | -------------------------------- |
| Method      | `GET`                            |
| URL         | `https://hanmajid.com/api/chats` |
| Description | Get all chats for user.          |

Success Response:
```json
[
    {
        "id": 1,
        "name": "Chris",
        "avatarPath": "http:\/\/placekitten.com\/g\/200\/200",
        "unreadMessages": 1,
        "lastMessage": {
            "content": "Ksjd",
            "timestamp": "2021-09-16T18:49:16Z",
            "isYou": true,
            "isRead": false
        }
    },
    {
        "id": 2,
        "name": "Cindy",
        "avatarPath": "http:\/\/placekitten.com\/200\/200",
        "unreadMessages": 0,
        "lastMessage": {
            "content": "Hello",
            "timestamp": "2021-07-31T11:36:44Z",
            "isYou": true,
            "isRead": false
        }
    }
]
```

#### 1.2. `GET` chat detail

|             |                                                   |
| ----------- | ------------------------------------------------- |
| Method      | `GET`                                             |
| URL         | `https://hanmajid.com/api/chats/{chatId}`         |
| Description | Get detail of a chat with the specified `chatId`. |

Success Response:
```json
{
    "id": 1,
    "name": "Chris",
    "avatarPath": "http:\/\/placekitten.com\/g\/200\/200",
    "unreadMessages": 1,
    "messages": [
        {
            "content": "Hi",
            "timestamp": "2019-04-16T18:42:49.608466Z",
            "isYou": false,
            "isRead": true
        },
        {
            "content": "Halo",
            "timestamp": "2019-04-16T18:42:49.608466Z",
            "isYou": false,
            "isRead": true
        }
    ]
}
```

#### 1.3. `POST` new chat message

|             |                                                        |
| ----------- | ------------------------------------------------------ |
| Method      | `POST`                                                 |
| URL         | `https://hanmajid.com/api/chats/{chatId}`              |
| Description | Add new message to a chat with the specified `chatId`. |

Form Data:

| Name      | Type     | Description     | Required | Example  |
| --------- | -------- | --------------- | -------- | -------- |
| `message` | `String` | The new message | true     | `"Test"` |

Success Response:

```json
{
    "id": 2,
    "name": "Cindy",
    "avatarPath": "http://placekitten.com/200/200",
    "unreadMessages": 0,
    "messages": [
        {
            "content": "Hi",
            "timestamp": "2019-04-16T18:42:49.608466Z",
            "isYou": false,
            "isRead": true
        },
        {
            "content": "Hi",
            "timestamp": "2019-06-12T15:14:47Z",
            "isYou": true,
            "isRead": false
        },
        {
            "content": "Test",
            "timestamp": "2021-11-12T13:54:42Z",
            "isYou": true,
            "isRead": false
        }
    ]
}
```

### 2. Call Endpoints

#### 2.1. `GET` all calls

|             |                                  |
| ----------- | -------------------------------- |
| Method      | `GET`                            |
| URL         | `https://hanmajid.com/api/calls` |
| Description | Get all calls for user.          |

Success Response:
```json
[
    {
        "id": 1,
        "name": "Chris",
        "avatarPath": "http:\/\/placekitten.com\/g\/200\/200",
        "calls": [
            {
                "isIncoming": true,
                "isMissed": true,
                "timestamp": "2019-04-16T18:42:49.608466Z"
            },
            {
                "isIncoming": true,
                "isMissed": false,
                "timestamp": "2019-04-16T18:42:49.608466Z"
            }
        ]
    },
    {
        "id": 2,
        "name": "Cindy",
        "avatarPath": "http:\/\/placekitten.com\/200\/200",
        "calls": [
            {
                "isIncoming": false,
                "isMissed": false,
                "timestamp": "2019-04-16T18:42:49.608466Z"
            }
        ]
    }
]
```

### 3. Status Endpoints

#### 3.1. `GET` all statuses

|             |                                     |
| ----------- | ----------------------------------- |
| Method      | `GET`                               |
| URL         | `https://hanmajid.com/api/statuses` |
| Description | Get all statuses for user.          |

Success Response:
```json
[
    {
        "id": 1,
        "name": "Chris",
        "timestamp": "2019-04-16T18:42:49.608466Z",
        "isSeen": true,
        "numImages": 2,
        "thumbnailPath": "https:\/\/picsum.photos\/200\/300"
    },
    {
        "id": 2,
        "name": "Cindy",
        "timestamp": "2019-04-16T18:42:49.608466Z",
        "isSeen": false,
        "numImages": 3,
        "thumbnailPath": "https:\/\/picsum.photos\/400\/600"
    }
]
```

#### 3.2. `GET` status detail

|             |                                                       |
| ----------- | ----------------------------------------------------- |
| Method      | `GET`                                                 |
| URL         | `https://hanmajid.com/api/statuses/{statusId}`        |
| Description | Get detail of a status with the specified `statusId`. |

Success Response:
```json
{
    "id": 1,
    "name": "Chris",
    "timestamp": "2019-04-16T18:42:49.608466Z",
    "isSeen": true,
    "numImages": 2,
    "images": [
        {
            "path": "https:\/\/picsum.photos\/200\/300"
        },
        {
            "path": "https:\/\/picsum.photos\/250\/350"
        }
    ]
}
```
