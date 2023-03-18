import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'
import { List } from 'reselect/es/types'
import { Device } from './device_service'
import { User } from './user_service'

export interface UserTreatmentSessionListResponse {
    sessions: List<UserTreatmentSession>
}

export interface UserTreatmentSession {
    id: string
    user_id: string
    device_id: string
    protocolId: string
    SelectedPainLevel: string
    SelectedTemperature: string
    initialSelectedTime: string
    initialBatteryLevel: string
    finalTemperature: string
    actualTreatmentTime: string
    endBatteryLevel: string
    feedbackPainLevel: string
    createdDate: string
    user: User
    device: Device
}

export interface GeneralResponse {
    state: string
    stateDescription: string
}

export type GetSessionFilters = {
    type: string
    id: string
}

export type GetSessionQuestionsResponse = {
    questionAnswers: Map<string, string>
}

export const sessionApi = createApi({
    reducerPath: 'sessionApi',
    baseQuery: fetchBaseQuery({
        baseUrl: 'http://18.136.146.172/achilles-api/',
        prepareHeaders: (headers) => {
            const token = localStorage.getItem("jwt") as string;
            if (!headers.has("Authorization") && token) {
                headers.set("Authorization", `Bearer ${token}`);
            }
            return headers;
        },
    }),
    tagTypes: ['sessions'],
    endpoints: (build) => ({
        getSessions: build.query<UserTreatmentSessionListResponse, { filter: GetSessionFilters }>({
            query: (data) => `user/sessions/${data.filter.type}/${data.filter.id}`,
            providesTags: [{ type: 'sessions', id: "getSessions" }]

        }),
        getSessionQuestions: build.query<GetSessionQuestionsResponse, {}>({
            query(body) {
                return {
                    url: `user/sessions/feedback`,
                    method: 'POST',
                    body,
                }
            },
        }),
    }),
})

export const {
    useGetSessionQuestionsQuery,
    useGetSessionsQuery
} = sessionApi