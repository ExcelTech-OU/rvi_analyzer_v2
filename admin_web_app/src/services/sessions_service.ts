import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'
import { List } from 'reselect/es/types'
import { Device } from './device_service'
import { User } from './user_service'

export interface UserTreatmentSessionListResponse {
    sessions: List<UserTreatmentSession>
}

export interface ModeOnesResponse {
    status: string
    statusDescription: string
    sessions: List<ModeOneDto>
}

export interface ModeOneDto {
    createdBy: string
    defaultConfigurations: DefaultConfiguration
    sessionConfigurationModeOne: SessionConfigurationModeOne
    status: string
    results: List<SessionResult>
}

export interface DefaultConfiguration {
    customerName: string
    operatorId: string
    batchNo: string
    sessionId: string
}

export interface SessionConfigurationModeOne {
    voltage: string
    maxCurrent: string
    passMinCurrent: string
    passMaxCurrent: string
}

export interface SessionResult {
    testId: string
    readings: List<Reading>
}

export interface Reading {
    temperature: string
    current: string
    voltage: string
    readAt: string
    result: string
}

export interface ModeTwosResponse {
    status: string
    statusDescription: string
    sessions: List<ModeTwoDto>
}

export interface ModeTwoDto {
    createdBy: string
    defaultConfigurations: DefaultConfiguration
    sessionConfigurationModeTwo: SessionConfigurationModeTwo
    status: string
    results: List<SessionResult>
}

export interface SessionConfigurationModeTwo {
    current: string
    maxVoltage: string
    passMinVoltage: string
    passMaxVoltage: string
}

export interface ModeThreesResponse {
    status: string
    statusDescription: string
    sessions: List<ModeThreeDto>
}

export interface ModeThreeDto {
    createdBy: string
    defaultConfigurations: DefaultConfiguration
    sessionConfigurationModeThree: SessionConfigurationModeThree
    status: string
    results: SessionResult
}

export interface SessionConfigurationModeThree {
    startingVoltage: string
    desiredVoltage: string
    maxCurrent: string
    voltageResolution: string
    chargeInTime: string
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
        baseUrl: 'http://127.0.0.1:7550/',
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
        getModeOneSessions: build.query<ModeOnesResponse, {}>({
            query: (data) => `rvi/analyzer/v1/session/get/one`,
            providesTags: [{ type: 'sessions', id: "getModeOneSessions" }]

        }),
        getModeTwoSessions: build.query<ModeTwosResponse, {}>({
            query: (data) => `rvi/analyzer/v1/session/get/two`,
            providesTags: [{ type: 'sessions', id: "getModeTwoSessions" }]

        }),
        getModeThreeSessions: build.query<ModeThreesResponse, {}>({
            query: (data) => `rvi/analyzer/v1/session/get/three`,
            providesTags: [{ type: 'sessions', id: "getModeThreeSessions" }]

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
    useGetModeTwoSessionsQuery,
    useGetModeThreeSessionsQuery,
    useGetModeOneSessionsQuery
} = sessionApi