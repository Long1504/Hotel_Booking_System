package com.hotel_booking_system.mapper;

import com.hotel_booking_system.dto.request.CreateUserRequest;
import com.hotel_booking_system.dto.response.UserResponse;
import com.hotel_booking_system.entity.Role;
import com.hotel_booking_system.entity.User;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;

import java.util.Set;
import java.util.stream.Collectors;

@Mapper(componentModel = "spring")
public interface UserMapper {
    @Mapping(target = "roles", ignore = true)
    User toUser(CreateUserRequest request);

    @Mapping(source = "roles", target = "roles", qualifiedByName = "mapRolesToStrings")
    UserResponse toUserResponse(User user);
    @Named("mapRolesToStrings")
    default Set<String> mapRolesToStrings(Set<Role> roles) {
        if (roles == null) {
            return null;
        }
        return roles.stream()
                .map(role -> role.getRoleName())
                .collect(Collectors.toSet());
    }
}
